package com.ksoft.base.service.manager.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import com.ksoft.base.service.manager.util.AssertValue;

public class IoUtil {
	private static final int BUFFERSIZE = 4096;

	// hide default constructor
	private IoUtil() {
	}

	public static byte[] readBytes(String filePaht) throws IOException {
		BufferedInputStream in = null;
		ByteArrayOutputStream out = null;

		try {
			in = new BufferedInputStream(new FileInputStream(filePaht));

			out = new ByteArrayOutputStream(1024);

			byte[] temp = new byte[1024];

			int size = 0;

			while ((size = in.read(temp)) != -1) {
				out.write(temp, 0, size);
			}

			return out.toByteArray();
		} finally {
			in.close();
			out.close();
		}

	}

	public static byte[] readBytes(InputStream inputStream) throws IOException {
		if (inputStream == null)
			throw new IllegalArgumentException("InputStream cannot be null");

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		transfer(inputStream, outputStream);
		byte[] bytes = outputStream.toByteArray();
		outputStream.close();
		return bytes;
	}

	public static byte[] readBytesForClassPath(String filePath)
			throws IOException {
		InputStream is = null;
		try {
			URL url = IoUtil.class.getResource("/" + filePath);
			is = url.openStream();

			return readBytes(is);
		} finally {
			if (is != null) {
				is.close();
			}
		}
	}

	public static Map<String, byte[]> readZip(ZipInputStream zipInputStream)
			throws IOException {

		ZipEntry zipEntry = zipInputStream.getNextEntry();

		Map<String, byte[]> fileMap = new HashMap<String, byte[]>();

		while (zipEntry != null) {
			String entryName = zipEntry.getName();

			if (AssertValue.isNotNullAndNotEmpty(entryName)) {

				byte[] bytes = IoUtil.readBytes(zipInputStream);
				if (bytes != null && bytes.length > 0) {
					fileMap.put(entryName.trim(), bytes);
				}
			}
			zipEntry = zipInputStream.getNextEntry();
		}

		return fileMap;
	}

	public static String readAsciiFile(String fileName) throws IOException {
		FileReader fr = null;
		char[] thechars = null;

		try {
			File thefile = new File(fileName);
			fr = new FileReader(thefile);
			int size = (int) thefile.length();
			thechars = new char[size];

			int count, index = 0;

			// read in the bytes from the input stream
			while ((count = fr.read(thechars, index, size)) > 0) {
				size -= count;
				index += count;
			}
		} finally {
			if (fr != null)
				fr.close();
		}

		return new String(thechars);

	}

	public static String readAsciiFileForClassPath(String filePath)
			throws IOException {
		return readAsciiFileForClassPath(filePath, null);
	}

	public static String readAsciiFileForClassPath(String filePath,
			ClassLoader classLoader) throws IOException {
		InputStream is = null;
		try {
			URL url = null;
			if (AssertValue.isNotNull(classLoader)) {
				url = classLoader.getResource("/"+filePath);
			} else {
				url = IoUtil.class.getResource("/"+filePath);
			}

			is = url.openStream();

			InputStreamReader isr = new InputStreamReader(is);

			BufferedReader br = new BufferedReader(isr);

			String s = null;
			String fileText = "";
			while ((s = br.readLine()) != null) {
				fileText = fileText + s;
			}

			return fileText;
		} finally {
			if (is != null) {
				is.close();
			}
		}
	}

	public static int transfer(InputStream in, OutputStream out)
			throws IOException {
		if (in == null || out == null)
			throw new IllegalArgumentException("In/OutStream cannot be null");

		int total = 0;
		byte[] buffer = new byte[BUFFERSIZE];
		int bytesRead = in.read(buffer);

		while (bytesRead != -1) {
			out.write(buffer, 0, bytesRead);
			total += bytesRead;
			bytesRead = in.read(buffer);
		}
		return total;
	}

	public static byte[] writeObjectToByte(Object object) throws IOException {
		if (!AssertValue.isNotNull(object)) {
			return null;
		}

		ByteArrayOutputStream byteOut = null;

		try {
			byteOut = new ByteArrayOutputStream();
			ObjectOutputStream outObj = new ObjectOutputStream(byteOut);
			outObj.writeObject(object);

			return byteOut.toByteArray();
		} finally {
			if (byteOut != null) {
				byteOut.close();
			}
		}
	}

	public static Object readBytesToObject(byte[] bytes) throws IOException,
			ClassNotFoundException {
		if (!AssertValue.isNotNull(bytes)) {
			return null;
		}

		ByteArrayInputStream byteInput = null;

		try {
			byteInput = new ByteArrayInputStream(bytes);
			ObjectInputStream inObj = new ObjectInputStream(byteInput);

			return inObj.readObject();

		} finally {
			if (byteInput != null) {
				byteInput.close();
			}
		}
	}
}
